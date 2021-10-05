# Allow ".foo" as an extension for files with the MIME type "text/plain".
Paperclip.options[:content_type_mappings] = {
  foo: %w(text/plain)
}