module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /^home$/
      '/'

    when /^Consumer settings$/
      '/auth/consumers/edit'

    when /^(Admin|Consumer|Employee) sign (in|up)$/
    "/auth/#{Regexp.last_match(1).downcase.pluralize}/sign_#{Regexp.last_match(2)}"

    when /^(Admin|Consumer|Employee) (.*)'s profile page$/
      "/auth/#{Regexp.last_match(1).downcase.pluralize}/#{Regexp.last_match(2)}"

    when /^new (Admin|Employee|Enterprise)$/
      "/#{Regexp.last_match(1).downcase.pluralize}/new"

    when/^edit (Admin|Employee|Enterprise) "(.*)"$/
      "/#{Regexp.last_match(1).downcase.pluralize}/#{Regexp.last_match(2)}/edit"

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
