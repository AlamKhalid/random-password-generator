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

  def start_password_generation(password_inclusion_options, password_length)
    # random seed
    srand(Time.new.to_i)
    password_items_array = generate_password_items_array(password_inclusion_options)
    length_password_items_array = password_items_array.length
    generated_password_str = +''
    password_length.times do
      # length of password
      generated_password_str << password_items_array[rand(0...length_password_items_array)]
    end
    generated_password_str
  end

  def validate_input(options, password_length)
    unless options.length.between?(1, 4)
      puts 'Invalid option length'
      return false
    end
    begin
      Integer(password_length)
    rescue ArgumentError, TypeError
      puts 'Invalid password length'
      return false
    end
    true
  end

  def generate_password
    puts 'Random Password Generator
1. Include Alphabets
2. Include Numerics
3. Include Speical Characters

Note: Enter 123 in any order for all three to be included,
12 for only alphabets and numerics and 3 only for special characters

Choice: '
    password_inclusion_options = gets
    puts 'Enter length for password: '
    password_length = gets
    return unless validate_input(password_inclusion_options, password_length)

    puts "Generated password is: #{start_password_generation(password_inclusion_options, password_length.to_i)}"
  end
end

RandomPasswordGenerator.new.generate_password
