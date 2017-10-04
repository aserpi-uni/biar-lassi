module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /^home$/
      '/'

    when /^(Admin|Consumer|Employee) sign (in|up)$/
      "/#{Regexp.last_match(1).downcase.pluralize}/sign_#{Regexp.last_match(2)}"

    when /^(Admin|Consumer|Employee) (.*)'s profile page$/
      "/#{Regexp.last_match(1).downcase.pluralize}/#{Regexp.last_match(2)}"

    when /^(new|edit) (Employee|Enterprise)$/
      "/#{Regexp.last_match(2).downcase.pluralize}/#{Regexp.last_match(1)}"

    else
      begin
        page_name =~ /(.*)/
        path_components = Regexp.last_match(1).split(/\s+/)
        send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \\\"#{page_name}\\\" to a path.\\nNow, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
