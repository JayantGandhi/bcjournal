class Post < ActiveRecord::Base

  before_save :clean_notes, :mark_notes

  mount_uploader :cover_image, CoverImageUploader
  mount_uploader :audio, AudioUploader

  belongs_to :issue

  has_many :sections, -> { order 'position ASC' }

  has_and_belongs_to_many :verticals
  has_and_belongs_to_many :slideshows

  has_and_belongs_to_many(:posts,
    :join_table => "related_articles",
    :foreign_key => "post_a_id",
    :association_foreign_key => "post_b_id")

  acts_as_taggable
  acts_as_taggable_on :authors

  accepts_nested_attributes_for :sections, allow_destroy: true
  accepts_nested_attributes_for :verticals, allow_destroy: true

  validates :title, presence: true
  validates :blurb, presence: true, length: {maximum: 400}
  validates :slug,
    uniqueness: {
      case_sensitive: false
    },
    presence: true

  # scopes
  scope :published, -> { where(published: true) }
  scope :not_book_review, -> { where(book_review: false) }
  scope :book_review, -> { where(book_review: true) }
  scope :interview, -> {where(article_type: 'interview')}

  # methods
  def to_param
    slug
  end

  def self.search(search)
    if search
      where('lower(title) LIKE ? OR lower(blurb) LIKE ? OR lower(abstract) LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%")
    else
      all
    end
  end

  def build_slug(add_year=false)
    self.slug = self.title.downcase.gsub(" ", "-").gsub(/\?|\&|\=|\$|\@|\#|\,|\.|\%|\;|\:/, '')

    # make sure it's unique, if not add the year
    if Post.where(slug: self.slug).length > 1
      build_slug(true)
    end

    if add_year
      self.slug = self.title.downcase.gsub(" ", "-").gsub(/\?|\&|\=|\$|\@|\#|\,|\.|\%|\;|\:|\\|\//, '') + "-#{self.publish_date.strftime('%Y')}"
    end
  end

  def convert_by_line
    authors_array = self.by_line.split(/[,&]/).map(&:strip)

    for author in authors_array
      self.author_list.push(author) if !self.author_list.include?(author)
    end
  end

  private

    def clean_notes
      if self.sections.blank?
        # No need to do anything
        return
      end

      self.sections.each_with_index.map { |section, index|
        section_html = Nokogiri::HTML(section.body)
        section_links = section_html.css("a[href*='bcjournal'], a[href*='note'], a.footnote, a[href*='_edn']")

        for link in section_links
          linkNumber = link.content.gsub(/[\[\]]+/, '')
          if linkNumber !~ /\A\d+\z/
            linkNumber = to_decimal(linkNumber)
          end
          link['href'] = "#note_#{linkNumber}"
          link['id'] = "anchor_note_#{linkNumber}"
          link.content = "[#{linkNumber}]"
        end

        self.sections[index].body = section_html.to_s
      }
    end

    def mark_notes
      if self.notes.blank?
        # do nada
        return
      end

      notes_html = Nokogiri::HTML(self.notes)

      # if there is no list don't show it until it's fixed
      if !notes_html.at_css('ol, ul')
        self.notes = ''
        return
      end

      the_notes = notes_html.css("li")

      the_notes.each_with_index.map { |note, index|
        noteNumber = index + 1
        note['id'] = "note_#{noteNumber}"

        # add a return button if it's not there
        if !note.at_css('.return')
          note << "<a href='#anchor_note_#{noteNumber}'><span class='return icon-angle-up'></span></a>"
        end
      }

      self.notes = notes_html.to_s
    end

    def to_decimal value
      @base_digits = {
        1    => 'I',
        4    => 'IV',
        5    => 'V',
        9    => 'IX',
        10   => 'X',
        40   => 'XL',
        50   => 'L',
        90   => 'XC',
        100  => 'C',
        400  => 'CD',
        500  => 'D',
        900  => 'CM',
        1000 => 'M'
      }
      value = value.upcase
      result = 0
      @base_digits.values.reverse.each do |roman|
        while value.start_with? roman
          value = value.slice(roman.length, value.length)
          result += @base_digits.key roman
        end
      end
      result
    end
end
