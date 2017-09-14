class PdfGeneratorService

  def initialize(order)
    @order = order
  end

  def generate_invoice
    # Render PDF file
    # TODO: This is WIP. Needs to be extracted to a module
    pdf_opts = {
        page_size: 'A4',
        page_layout: :portrait, left_margin: 20, right_margin: 20,
        top_margin: 20, bottom_margin: 20, skip_encoding: true
    }
    helpers = ActionController::Base.helpers
    filename = [I18n.t('invoice.header'), @order.id, @order.billing_name].join('-') + '.pdf'
    Prawn::Document.generate(filename, pdf_opts) do |pdf|
      pdf.move_down 50
      pdf.font Rails.root.join('app', 'assets', 'fonts', 'futura.ttf')
      pdf.text I18n.t('invoice.header'), size: 40
      pdf.move_down 30
      pdf.font Rails.root.join('app', 'assets', 'fonts', 'futura.ttf')
      pdf.text @order.billing_name, size: 14
      pdf.move_down 16
      pdf.text "Tax (VAT): #{helpers.humanized_money_with_symbol @order.taxes}", size: 14
      pdf.move_down 16
      pdf.text "Total: #{helpers.humanized_money_with_symbol @order.total}", size: 14
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