module NamesHelper
  def construct_by_line(post)
    by_line = ''
    author_names = []

    for author in post.authors
      author_names.push(author.name)
    end

    by_line = place_author_in_list(author_names)

    return by_line
  end

  def last_name_first_name(full_name)
    names = full_name.split(' ')
    number_of_names = names.length
    last_name_first = "#{names[number_of_names-1]},"

    names.each_with_index do |name, index|
      if index + 1 == number_of_names #reached last name
        break
      else
        last_name_first += " #{name}"
      end
    end

    return last_name_first
  end

  ###
  # builds a list of authors last name, first name (middle name)
  ###
  def construct_author_list(post, is_apa = false)
    author_names = []
    author_list = ''

    for author in post.authors
      author_names.push(author.name)
    end

    if is_apa
      author_names.sort!

      author_names.each_with_index do |name, index|
        author_names[index] = last_name_first_name(name)
      end
    else
      #reverse the first name only
      author_names[0] = last_name_first_name(author_names[0])
    end

    number_of_authors = author_names.length

    author_list = place_author_in_list(author_names)

    return author_list
  end

  private
    def place_author_in_list(author_array)
      number_of_authors = author_array.length
      author_list = ''

      author_array.each_with_index do |name, index|
        if index + 1 == 1
          author_list = name

          if number_of_authors == 1 #the only one
            break
          end
        elsif index + 1 == number_of_authors #the last one
          author_list += " & #{name}"
        elsif index == 5 #time to add 'et al.' and exit
          author_list += ", et al"
          break
        else #somewhere in the middle
          author_list += ", #{name}"
        end
      end

      return author_list
    end
end