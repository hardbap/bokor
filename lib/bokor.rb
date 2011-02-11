require 'socket'

class Bokor
  VERSION = "0.0.1"

  MINUS    = "-"
  PLUS     = "+"
  COLON    = ":"
  DOLLAR   = "$"
  ASTERISK = "*"

  COMMAND_DELIMITER = "\r\n"

  def initialize
    @sock = nil
  end

  def connect(host = "127.0.0.1", port = 8091)
    @sock = TCPSocket.new(host, port)
    @sock.setsockopt Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1
  end

  def disconnect
    @sock.close
  end

  def execute(command)

  end

  def echo(text = "hello")
    write(build_command("ECHO", text))
  end

  def browser
    write(build_command("BROWSER"))
  end

  def write(command)
    command.each { |c| @sock.write(c) }
  end

  def read
    @sock.gets
  end

  def build_command(name, *args)
    command = []
    command << "*#{args.length + 1}#{COMMAND_DELIMITER}"
    command << "$#{name.to_s.bytesize}#{COMMAND_DELIMITER}#{name}"

    args.each do |arg|
      command << "$#{arg.to_s.bytesize}#{COMMAND_DELIMITER}#{arg}"
    end

    command
  end
end
