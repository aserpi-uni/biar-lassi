module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /^home$/
      '/'

    when /^(Admin|Consumer) sign (in|out|up)$/
      "/auth/#{Regexp.last_match(1).downcase.pluralize}/sign_#{Regexp.last_match(2)}"

    when /^(Employee|Operator|Supervisor) sign (in|out)$/
      "/auth/employees/sign_#{Regexp.last_match(2)}"

    when /^(Admin|Consumer|Employee) (.*)'s profile page$/
      "/auth/#{Regexp.last_match(1).downcase.pluralize}/#{Regexp.last_match(2)}"

    when /^new (Admin|Enterprise|Product)$/
      "/#{Regexp.last_match(1).downcase.pluralize}/new"

    when /^new (Employee|Operator|Supervisor)$/
      '/employees/new'

    when /^edit (Admin|Employee|Enterprise) "(.*)"$/
      "/#{Regexp.last_match(1).downcase.pluralize}/#{Regexp.last_match(2)}/edit"

    when /^Facebook connect$/
      '/auth/consumers/auth/facebook'

    when /^Facebook disconnect$/
      '/auth/consumers/facebook/disconnect'

    when /^ new (ProblemThread|AdviceThread)$/
      "/products/1/#{Regexp.last_match(1).underscore.pluralize}/new"

    when /^ new (ProblemThread|AdviceThread)Comment$/
      "/#{Regexp.last_match(1).underscore.pluralize}/1/comments/new"

      when /^ new (ProblemThread|AdviceThread)Relationship $/
        "/#{Regexp.last_match(1).underscore.pluralize}/1/relationships/new"

    else
      begin
        page_name =~ /(.*)/
        path_components = Regexp.last_match(1).split(/\s+/)
        send(path_components.push('path').join('_').to_sym)
      rescue Object => _e
        raise "Can't find mapping from \\\"#{page_name}\\\" to a path.\\nNow, go and add a mapping in #{__FILE__}"
      end
    end
  end

  def settings_path_to(res)
    if res.is_a?(Admin) || res.is_a?(Employee)
      "/#{res.class.name.downcase.pluralize}/#{res.username}/edit"
    elsif res.is_a? Consumer
      '/auth/consumers/edit'
    elsif res.is_a? Enterprise
      "/enterprises/#{res.name}/edit"
    elsif res.is_a? Product
      "/products/#{res.id}/edit"
    elsif res.is_a? ProblemThread
      "/problem_threads/#{res.id}/edit"
    elsif res.is_a? AdviceThread
      "/advice_threads/#{res.id}/edit"
    elsif res.is_a?Comment
      "/comments/#{res.id}/edit"
    end
  end
end

World(NavigationHelpers)
