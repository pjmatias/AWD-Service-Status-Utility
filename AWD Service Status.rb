require_relative 'awd_classes.rb'
env = String.new
dpc = String.new
uri = URI.parse('http://www.google.com')

credentials = Proc.new do |e,d|
		print "User name:"
		$user = gets.chomp
		print "Password:"
		$password = STDIN.noecho(&:gets).chomp
		test = AwdCall.new(e, d)
		testlogin = test.getmodellist
		case testlogin.code
			when '401'
				puts testlogin.body
				raise 'AWD login error!'
			else
				puts
		end
end

env_input = Proc.new do
	print "Environment:"
	env = gets.chomp.downcase
	print "Is env on DPC? (Y or N):"
	dpc = gets.chomp.upcase
	credentials.call(env, dpc)
end

env_input.call

case dpc
	when "N"
		uri = URI.parse("#{$server}#{env}pp/awdServer/awd/services/v1/system/services")
	when "Y"
		uri = URI.parse("#{$server_dpc_non}#{env}app/awdServer/awd/services/v1/system/services")
	when "P"
		uri = URI.parse("#{$server_dpc_prod}#{env}app/awdServer/awd/services/v1/system/services")
	else
		puts
end

http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)
request.basic_auth $user, $password
http.use_ssl = (uri.scheme == 'https')
http.ca_file = 'cacert.pem'
response = http.request(request)

File.open('sysstatus.xml', 'w') do |f|
  f.write(response.body)
  end

puts "sysstatus.xml file successfully updated with #{env} data." unless response.code != '200'