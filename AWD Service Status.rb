require_relative 'awd_classes.rb'
env = String.new
dpc = String.new

credentials = Proc.new do |e,d|
		print "User name:"
		$user = gets.chomp
		print "Password:"
		$password = STDIN.noecho(&:gets).chomp
		test = AwdCall.new(e, d)
		testlogin = test.getmodellist
		case testlogin.code
			when '200'
				puts
			else
				puts testlogin.body
				raise 'AWD login error!'
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

call = AwdCall.new(env, dpc, "services/v1/system/services")
response = call.nocontent('get')

File.open('sysstatus.xml', 'w') do |f|
  f.write(response.body)
  end

response.code == '200' ? (puts "sysstatus.xml file successfully updated with #{env} data.") : (puts "Error accessing #{env} server status. Response code #{response.code}")