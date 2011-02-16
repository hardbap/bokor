$:.unshift File.expand_path('../lib', File.dirname(__FILE__))

require 'test/unit'
require 'bokor'

class BokorTest < Test::Unit::TestCase
  def setup
    @bokor = Bokor.new
    @bokor.connect
  rescue Errno::ECONNREFUSED
    puts <<-EOS

      Cannot connect to Zombie server.

    EOS
    exit 1
  end

  def teardown

  end

  def test_echo
    assert_match /\Ahello\z/, @bokor.echo
  end

  def test_visit
    assert_match /\AOK\z/, @bokor.visit("http://localhost.com:3000/")
  end

  def test_wait
    assert_match /\AOK\z/, @bokor.wait
  end

  def test_reset
    assert_match /\AOK\z/, @bokor.reset
  end
end
