class Article < ApplicationRecord
  belongs_to :user
  has_many :has_categories
  has_many :categories, through: :has_categories

  validates :title, :presence => {:message => ":  No puedes ingresar un titulo en blanco"}, uniqueness: {:message => ": Este titulo ya esta registrado prueba con otro"}
  validates :body, :presence => {:message => ":  Debes ingresar una descripcion de la actividad"}, length: {minimum: 2, maximum: 4000, :message => ":  La descripción debe tener minimo 10 caracteres"}
  before_save :set_visits_count
  after_create :save_categories

  has_attached_file :image, styles:{ :thumb => "281x139#", :medium =>"1280x720#", :high => "1920 x 1080#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  has_attached_file :imagefritzing, styles:{ :thumb => "281x139#", :medium =>"1280x720#", :high => "1920 x 1080#" }
  validates_attachment_content_type :imagefritzing, content_type: /\Aimage\/.*\Z/

  has_attached_file :imagematerials, styles:{ :thumb => "281x139#", :medium =>"1280x720#", :high => "1920 x 1080#" }
  validates_attachment_content_type :imagematerials, content_type: /\Aimage\/.*\Z/

  has_attached_file :imagearduino, styles:{ :thumb => "281x139#", :medium =>"1280x720#", :high => "1920 x 1080#" }
  validates_attachment_content_type :imagearduino, content_type: /\Aimage\/.*\Z/


  def categories=(value)
    @categories = value
  end


  def update_visits_count
    self.update(visits_count: self.visits_count + 1)
  end

  private

  def save_categories
    @categories.each do |category_id|
      HasCategory.create(category_id: category_id,article_id: self.id)
    end
  end

  def set_visits_count
    self.visits_count ||= 0
  end
end
