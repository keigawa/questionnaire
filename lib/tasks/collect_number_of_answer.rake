namespace :collect_number_of_answer do
  desc 'collect numbers'

  task collect: :environment do
    num = ENV['Q_ID']
    number = Answer.where(question_id: ENV['Q_ID']).count
    checkbox = Checkbox.find_by(question_id: ENV['Q_ID'])
    if checkbox
      checkbox_option_num = CheckboxOption.where(checkbox_id: checkbox.id).count
      puts number / checkbox_option_num
    else
      puts 'Wrong ID'
    end
  end
end
