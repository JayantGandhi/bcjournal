module NamesHelper
  def article_by_line(article)
    number_of_authors = article.authors.length
    i = 0
    by_line = ""

    for author in article.authors
      i += 1

      if number_of_authors == 1
        by_line = "#{author.name}"
      else
        if i != number_of_authors
          if number_of_authors > 2
            by_line += "#{author.name},"
          else
            by_line = "#{author.name}"
          end
        else
          by_line += " & #{author.name}"
        end
      end
    end

    return by_line
  end
end