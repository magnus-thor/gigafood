class PdfGeneratorService

  def initialize(order)
    @order = order
  end

  def generate_invoice

    helpers = ActionController::Base.helpers
    filename = [I18n.t('invoice.header'), @order.id, @order.billing_name].join('-') + '.pdf'
    # Render PDF file
    # TODO: This is WIP. Needs to be extracted to a module
    binding.pry
    pdf = Prawn::Document.new()
    pdf.define_grid(columns: 5, rows: 8, gutter: 10)

    pdf.grid([0, 0], [1, 1]).bounding_box do
      pdf.text I18n.t('invoice.header'), size: 18
      pdf.text "Invoice No: 0001", :align => :left
      pdf.text "Date: #{Date.today.to_s}", :align => :left
      pdf.move_down 10

      pdf.text "Attn: To whom it may concern "
      pdf.text "Company Name"
      pdf.text "Tel No: 1"
      pdf.text "Fax No: 0`  1"
    end

    pdf.grid([0, 3.6], [1, 4]).bounding_box do
      logo_path = File.expand_path(Rails.root.join('app', 'assets', 'images', 'gigafood_logo.png'))

      # Displays the image in your PDF. Dimensions are optional.
      pdf.image logo_path, height: 50, position: :left

      # Company address
      pdf.move_down 10
      pdf.text "Awesomeness Ptd Ltd", :align => :left
      pdf.text "Address", :align => :left
      pdf.text "Street 1", :align => :left
      pdf.text "40300 Shah Alam", :align => :left
      pdf.text "Selangor", :align => :left
      pdf.text "Tel No: 42", :align => :left
      pdf.text "Fax No: 42", :align => :left
    end


    temp_arr = [{:name => 'Unit 1', :price => "10.00"},
                {:name => 'Unit 2', :price => "12.00"}]

    pdf.move_down 10
    items = [["No", "Description", "Qt.", "RM"]]
    items += temp_arr.each_with_index.map do |item, i|
      [
          i + 1,
          item[:name],
          "1",
          item[:price],
      ]
    end
    items += [["", "Total", "", "22.00"]]

    pdf.table items, :header => true, width: 648,
              :column_widths => {0 => 50, 1 => 350, 3 => 100}, :row_colors => ["d2e3ed", "FFFFFF"] do
      style(columns(3)) { |x| x.align = :right }
      pdf.text "Tax (VAT): #{helpers.humanized_money_with_symbol @order.taxes}", size: 14
      pdf.move_down 16
      pdf.text "Total: #{helpers.humanized_money_with_symbol @order.total}", size: 14
    end


    Prawn::Document.generate(filename, pdf_opts) do |pdf|
      pdf.move_down 50
      pdf.font Rails.root.join('app', 'assets', 'fonts', 'futura.ttf')
      pdf.text I18n.t('invoice.header'), size: 40
      pdf.move_down 30
      pdf.font Rails.root.join('app', 'assets', 'fonts', 'futura.ttf')
      pdf.text @order.billing_name, size: 14
      pdf.move_down 16

    end

    # Attach file to @order with file_type :invoice
    # TODO: This is WIP. Needs to be extracted to a module
    generated_file = File.open(Rails.root.join(filename))
    if @order.attachments.create(file: generated_file, file_type: :invoice)
      if File.exist?(generated_file)
        File.delete(generated_file)
      end
    end
  end


end