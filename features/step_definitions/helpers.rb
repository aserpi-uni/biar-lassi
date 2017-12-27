# Checks if a user is a Employee
def employee?(str)
  %w[employee operator supervisor].include?(str)
end
