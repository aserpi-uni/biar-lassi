Given(/^I created (an Admin|a Consumer) account with username "([^"]*)" and email "([^"]*)"$/)  do |klass, name, email|
  if klass == 'an Admin' && !Admin.find_by(username: name)
    admin = Admin.new(email: email, password: 'password', username: name)
    admin.skip_confirmation!
    admin.save!
  elsif klass == 'a Consumer' && !Consumer.find_by(username: name)
    consumer = Consumer.new(email: email, password: 'password', username: name)
    consumer.skip_confirmation!
    consumer.save!
  end
end

Given(/^I created an Employee account with username "([^"]*)", email "([^"]*)" and role "(analyst|operator|supervisor)"$/)  do |name, email, role|
  employee = Employee.find_by(username: name)
  if employee
    unless employee.role == role
      employee.role = role
      employee.save!
    end
  else
    admin = Employee.new(email: email, password: 'password', role: role, username: name)
    admin.skip_confirmation!
    admin.save!
  end
end
