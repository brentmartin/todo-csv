require 'csv'

class Todo
  attr_accessor :todos

  def initialize(file_name)
    @file_name = file_name #Don't touch this line or var
    # You will need to read from your CSV here and assign them to the @todos variable. make sure headers are set to true
    @todos = CSV.read(@file_name, {headers: true})
  end

  def start
    loop do
      system('clear')

      puts "---- TODO.rb ----"

      view_todos

      puts
      puts "What would you like to do?"
      puts "1) Exit 2) Add Todo 3) Mark Todo As Complete 4) Edit Todo 5) Delete Todo"
      print " > "
      action = gets.chomp.to_i
      case action
      when 1 then exit
      when 2 then add_todo
      when 3 then mark_todo
      when 4 then edit_todo
      when 5 then delete_todo
      else
        puts "\a"
        puts "Not a valid choice"
      end
    end
  end

  def view_todos
    puts "Unfinished"
    @todos.each_with_index do |todo, index|
      puts "#{index + 1}) #{todo["name"]}"
    end
    puts "Completed"
  end

  def add_todo
    print "Name of Todo > "
    line_name = get_input
    @todos << [line_name, "no"]
  end

  def mark_todo
    print "Which todo have you finished?"
    mark_input = get_input.to_i
    @todos[mark_input-1][1] = "yes"
    # require 'pry';binding.pry
  end

  def edit_todo
    puts "Which todo would you like to edit?"
    print "> "
    edit_input = get_input.to_i
    puts "What do you want to edit the item to?"
    print "> "
    item_name = get_input
    @todos[edit_input-1][0] = item_name
  end

  def delete_todo
    puts "Which todo would you like to delete?"
    print "> "
    delete_input = get_input.to_i
    @todos.delete(delete_input-1)
  end

  def todos
    @todos
  end

  private # Don't edit the below methods, but use them to get player input and to save the csv file
  def get_input
    gets.chomp
  end

  def save!
    File.write(@file_name, @todos.to_csv)
  end
end
