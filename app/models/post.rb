class Post < ActiveRecord::Base

  before_save :clean_notes

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
      where('title LIKE ?', "%#{search}%")
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
        # puts 'OIM IN A SEKSHUN'
        section_html = Nokogiri::HTML(section.body)
        # puts section_html
        section_links = section_html.css("a[href*='bcjournal.org']")
        # puts section_links
        for link in section_links
          linkNumber = link.content.gsub(/[\[\]]+/, '')
          link['href'] = "note_#{linkNumber}"
        end
        self.sections[index].body = section_html.to_s
        puts self.sections[index].body
      }
    end
end
