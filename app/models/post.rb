class Post < ActiveRecord::Base

  before_save :clean_notes, :mark_notes

  mount_uploader :cover_image, CoverImageUploader

  has_many :sections, -> { order 'position ASC' }

  has_and_belongs_to_many :verticals
  has_and_belongs_to_many :slideshows

  acts_as_taggable

  accepts_nested_attributes_for :sections, allow_destroy: true
  accepts_nested_attributes_for :verticals, allow_destroy: true

  validates :title, presence: true
  validates :by_line, presence: true
  validates :blurb, presence: true, length: {maximum: 400}
  validates :slug,
    uniqueness: {
      case_sensitive: false
    },
    presence: true

  # scopes
  scope :published, -> { where(published: true) }

  # methods
  def to_param
    slug
  end

  def self.search(search)
    if search
      where('lower(title) LIKE ?', "%#{search.downcase}%")
    else
      all
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
        section_links = section_html.css("a[href*='bcjournal.org'], a[href*='#note_']")

        for link in section_links
          linkNumber = link.content.gsub(/[\[\]]+/, '')
          link['href'] = "#note_#{linkNumber}"
        end

        self.sections[index].body = section_html.to_s
      }
    end

    def mark_notes
      if self.notes.blank?
        # do nada
      end

      notes_html = Nokogiri::HTML(self.notes)
      the_notes = notes_html.css("li")

      the_notes.each_with_index.map { |note, index|
        note['id'] = "note_#{index + 1}"
      }

      self.notes = notes_html.to_s
    end
end
