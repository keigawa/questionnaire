class ValidationError < StandardError; end
class BlankEmail < StandardError; end
class BlankPassword < StandardError; end

begin
  raise BlankEmail
rescue BlankEmail => e
  puts e.message.to_s
end

begin
  raise BlankPassword
rescue BlankPassword => e
  puts e.message.to_s
end

begin
  raise ValidationError
rescue ValidationError => e
  puts e.message.to_s
end
