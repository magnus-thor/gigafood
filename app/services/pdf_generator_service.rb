class PdfGeneratorService

  def initialize(order)
    @order = order
  end

  def generate_invoice

    helpers = ActionController::Base.helpers
    filename = [I18n.t('invoice.header'), @order.id, @order.billing_name, rand(20000)].join('-') + '.pdf'
    # Render PDF file
    # TODO: This is WIP. Needs to be extracted to a module
    pdf = Prawn::Document.new()
    pdf.define_grid(columns: 5, rows: 8, gutter: 10)

    pdf.grid([0, 0], [1, 1]).bounding_box do
      logo_path = File.expand_path(Rails.root.join('app', 'assets', 'images', 'gigafood_logo.png'))

      # Displays the image in your PDF. Dimensions are optional.
      pdf.image logo_path, height: 50, position: :left

      # Company address
      pdf.move_down 10
      pdf.text 'FOOD FOR BILLIONS SWEDEN AB', align: :left


    end

    pdf.grid([0, 3.6], [1, 4]).bounding_box do
      pdf.text I18n.t('invoice.header'), size: 18
      pdf.text "Invoice # #{@order.id}", align: :left
      pdf.text "Date: #{Date.today.to_s}", align: :left
      pdf.move_down 10
      pdf.text "Attn: #{@order.billing_name}"
      pdf.text @order.billing_company
      pdf.text @order.billing_address if @order.billing_address
      pdf.text [@order.billing_postal_code, @order.billing_city].join(' ') if @order.billing_postal_code

      pdf.text "Phone: #{@order.billing_phone}"

    end

    # Add empty row and headers
    data = [['','','',''], %w(Product Price Qty Subtotal)]
    # Add order items
    @order.shopping_cart_items.each do |item|
      data << [item.item.name, helpers.humanized_money_with_symbol(item.item.price), item.quantity, helpers.humanized_money_with_symbol(item.subtotal)]
    end

    # Add VAT + Total
    data << ['', '', '', "Tax (VAT): #{helpers.humanized_money_with_symbol @order.taxes}" ]
    data << ['', '', '', "Total: #{helpers.humanized_money_with_symbol @order.total}" ]
    # Add last epmty row
    data << ['','','','']
    # A4 > 595.28 x 841.89

    pdf.table(data, width: 520, column_widths: [280, 60 ,30, 150]) do |table|
      #table.cells.padding = 10
      #table.cells.borders = []

      #row(0).borders = [:bottom]
      #row(0).border_width = 2
      table.row(0).font_style = :bold



      table.before_rendering_page do |page|
        page.row(0).border_top_width = 2
        #page.row(1).border_top_width = 2
        #page.row(0).border_left_width = 2
        #page.row(0).border_right_width = 2
        #page.row(1).column(1).border_left_width = 2
        #page.row(1).border_right_width = 2
        #page.row(-1).border_bottom_width = 2
        #page.row(-2).border_bottom_width = 2
        #page.row(-1).border_right_width = 2
        #page.row(-1).border_left_width = 2
        #page.row(-2).border_right_width = 2
        #page.row(-2).column(-1).border_left_width = 2
        page.rows(2..-2).borders = []
        page.column(-1).align = :right
        page.row(-1).font_style = :bold
      end

    end


    #Footer

    pdf.bounding_box([pdf.bounds.right - 550, pdf.bounds.bottom + 30], width: 800, height: 70) do
      pdf.text 'Food for Billions Sweden AB', align: :left, size: 9, style: :bold
      pdf.text '559040-1435', align: :left, size: 8
      pdf.text 'Tegelbacken 4A', align: :left, size: 8
      pdf.text '111 52 Stockholm', align: :left, size: 8

      pdf.text '070-736 39 62', align: :left, size: 8
      pdf.text 'invoice@gigafood.se', align: :left, size: 8
    end

    pdf.bounding_box([pdf.bounds.right - 250, pdf.bounds.bottom + 30], width: 800, height: 70) do
      pdf.text 'Handelsbanken', align: :left, size: 8
      pdf.text 'Bankgiro: 862-9305', align: :left, size: 8
      pdf.text 'Swish: 1230486472', align: :left, size: 8
    end

    # Finally render the pdf

    pdf.render_file filename

    # Attach file to @order with file_type :invoice
    # TODO: This is WIP. Needs to be extracted to a module
    generated_file = File.open(Rails.root.join(filename))
    if @order.attachments.create(file: generated_file, file_type: :invoice)
      # if File.exist?(generated_file)
      #   File.delete(generated_file)
      # end
    end
  end


end