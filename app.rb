require 'net/http'
require 'openssl'
require 'json'


Shoes.app width: 550, height: 350 do
 fill rgb(0, 0.6, 0.9, 0.1)
      stroke rgb(0, 0.6, 0.9)
      strokewidth 0.25



      100.times do
        oval(left:   rand(-5..self.width),
             top:    rand(-5..self.height),
             radius: rand(25..50))
      end



uri = URI('https://api.chucknorris.io/jokes/random')


req = Net::HTTP::Get.new(uri.path)

res = Net::HTTP.start(
        uri.host, uri.port,
        :use_ssl => uri.scheme == 'https',
        :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |https|
  https.request(req)
end

   jhtml = JSON.parse(res.body)
 stack do
  @banner = banner "CHUCK NORRIS"
  @banner.style(stroke: blue, underline: "single", align: "center")
 end
  stack  do
    @image = image(jhtml["icon_url"])
    @image.style(align: "center")
  end
  stack do
    para jhtml["value"]
  end
  stack do
    button("Run from Norris!") { exit() }

  end

end