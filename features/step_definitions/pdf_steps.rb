Then(/^an invoice for the order should be created$/) do
  expect(@order.attachments.first.file_type).to eq 'invoice'
end

And(/^the invoice should contain "([^"]*)"$/) do |content|

  remote_pdf = open('spec/fixtures/tmp/tmp.pdf', 'wb') do |file|
    file << open(@order.attachments.first.file.url).read
  end
  pdf = PDF::Inspector::Text.analyze_file(remote_pdf)
  expect(pdf.strings).to include content
end