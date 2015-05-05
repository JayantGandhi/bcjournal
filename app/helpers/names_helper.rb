module NamesHelper
  def construct_by_line(post)
    by_line = ''
    number_of_authors = post.authors.length

    post.authors.each_with_index do |author, index|

      if index + 1 == 1
        by_line = author.name

        if number_of_authors == 1 #the only one
          break
        end
      elsif index + 1 == number_of_authors #the last one
        by_line += " & #{author.name}"
      else #somewhere in the middle
        by_line += ", #{author.name}"
      end
    end

    return by_line
  end
end