# https://github.com/duleorlovic/minitest_rails/blob/main/db/seeds.rb
logger = Logger.new($stdout)
Rake::Task["db:fixtures:load"].invoke

# This is optional. It will just iterate over records and apply .humanize where
# "LABEL" is used, for example
# test/fixtures/users.yml
# user_without_registration:
#   name: $LABEL name
# will be in database `user_without_registration Name` and after this block it
# will be `User Without Registration Name`
#
# More info about fixtures:
# https://github.com/rails/rails/blob/master/activerecord/lib/active_record/fixtures.rb
already_proccessed = []
Dir.entries("#{Rails.root}/test/fixtures").each do |file_name|
  next unless file_name.last(4) == ".yml"

  # foreach will read line by line
  File.foreach("#{Rails.root}/test/fixtures/#{file_name}").grep(/LABEL/) do |line|
    column = line.match(/(\w*):.*\$LABEL/)[1]
    klass = file_name[0..-5].singularize.camelize
    next if already_proccessed.include? "#{klass}-#{column}"

    logger.info "klass=#{klass} column=#{column}"
    klass.constantize.find_each do |item|
      next if item.send(column).is_a? ActionText::RichText
      next if column == "email"

      item.send "#{column}=", item.send(column).humanize
      item.save # some columns can not be saved with spaces so ignore them
    end
    already_proccessed.append "#{klass}-#{column}"
  end
end
logger.info "db:seed and db:fixtures:load completed"
