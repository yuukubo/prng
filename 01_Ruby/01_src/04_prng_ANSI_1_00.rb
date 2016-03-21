require "openssl"
require "base64"
require "readline"
require 'date'
# generate 10 pseudo random number with AES-256-CBC, based ANSI X9.17

# 暗号化するデータ, カウンタの初期値
data = ""
data = Readline.readline("data : type plaintext > ")
if data =~ /[0-9a-zA-Z]/
	puts "ok."
else
	puts "  type plaintext /[0-9a-zA-Z]/. try again! "
	sleep(2)
	exit(99)
end

# パスワード
pass = ""
pass = Readline.readline("password : type password > ")
if pass =~ /[0-9a-zA-Z]/
	puts "ok."
else
	puts "  type password /[0-9a-zA-Z]/. try again! "
	sleep(2)
	exit(99)
end

# salt
salt = OpenSSL::Random.random_bytes(8)

# 暗号化器を作成する
enc = OpenSSL::Cipher.new("AES-256-CBC")
enc.encrypt
# 鍵とIV(Initialize Vector)を PKCS#5 に従ってパスワードと salt から生成する
key_iv = OpenSSL::PKCS5.pbkdf2_hmac_sha1(pass, salt, 2000, enc.key_len + enc.iv_len)
key = key_iv[0, enc.key_len]
iv = key_iv[enc.key_len, enc.iv_len]
# 鍵とIVを設定する
enc.key = key
enc.iv = iv

puts
puts "generate 10 pseudo random number with AES-256-CBC, based ANSI X9.17"
puts
puts "data : #{data}, pass : #{pass} "
puts

10.times do
	# 暗号化する time with key
	encrypted_time = ""
	encrypted_time.to_s << enc.update(DateTime.now.strftime('%Y%m%d%H%M%S'))
	encrypted_time.to_s << enc.final
	# enc time XOR data
	!!encrypted_time = !!encrypted_time ^ !!data
	# 暗号化する (enc time XOR data) with key
	encrypted_data = ""
	encrypted_data.to_s << enc.update(encrypted_time.to_s)
	encrypted_data.to_s << enc.final
	puts OpenSSL::Digest::SHA1.new( encrypted_data.to_s )
	!!encrypted_data = !!encrypted_time ^ !!encrypted_data
	# 暗号化する (enc time XOR enc data) with key
	encrypted_data.to_s << enc.update(encrypted_data.to_s)
	encrypted_data.to_s << enc.final
	data = encrypted_data
end

puts
puts "process end"
sleep(2)
