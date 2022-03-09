# frozen_string_literal: true
require 'time'

class RandomPasswordGenerator
  def generate_password_items_array(option)
    password_items_array = []
    # include alphabets
    if option.include?('1')
      password_items_array << ('a'..'z').to_a
      password_items_array << ('A'..'Z').to_a
    end
    # include only special characters
    if option.include?('3')
      num_arr = ('0'..'9').to_a
      password_items_array << ('!'..'?').to_a.reject{ |item| num_arr.include?(item) }
    end
    # include only numerics
    password_items_array << ('0'..'9').to_a if option.include?('2')
    # flatten the array in the end
    password_items_array.flatten
  end

  def generate_password(argv)
    # random seed
    srand(Time.new.usec)
    password_items_array = generate_password_items_array(argv[0])
    length_password_items_array = password_items_array.length
    generated_password_str = +''
    password_length = argv[1].to_i
    password_length.times do
      # length of password
      generated_password_str << password_items_array[rand(0...length_password_items_array)]
    end
    generated_password_str
  end

  def main(argv)
    if argv.length == 2
      puts generate_password(argv)
    else
      puts 'Incorrect format'
    end
  end
end

RandomPasswordGenerator.new.main(ARGV)
