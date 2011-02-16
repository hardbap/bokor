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

  def echo(text = "hello")
    write(build_command("ECHO", text))
  end

  def visit(url)
    write(build_command("VISIT", url))
  end

  def wait
    write(build_command("WAIT"))
  end

  def reset
    write(build_command("RESET"))
  end

  def write(command)
    command.each { |c| @sock.write(c) }
    read
  end

  def read
    format_reply(@sock.read(1), @sock.gets)
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

  def format_reply(reply_type, line)
    case reply_type
    when PLUS then line.strip
    end
  end
end
