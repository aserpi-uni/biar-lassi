module NavigationHelpers
  def path_to(page_name)
    case page_name
      when /^home$/
        '/'

      when /^(Admin|Consumer|Employee) sign (in|up)$/
        "/#{$1.downcase.pluralize}/sign_#{$2}"

      when /^(Admin|Consumer|Employee) (.*)'s profile page$/
        "/#{$1.downcase.pluralize}/#{$2}"

      else
        begin
          page_name =~ /(.*)/
          path_components = $1.split(/\s+/)
          self.send(path_components.push('path').join('_').to_sym)
        rescue Object => e
          raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
                    "Now, go and add a mapping in #{__FILE__}"
        end
    end
  end
end

World(NavigationHelpers)
