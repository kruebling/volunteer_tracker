class Word
  @@list = []
  attr_reader :id
  attr_accessor :vocab, :definitions

  def initialize(vocab, definition)
    @vocab = vocab
    @definitions = [definition]
    @id = @@list.length + 1
  end

  def self.all()
    @@list
  end

  def self.clear()
    @@list = []
  end

  def self.find(id)
    word_id = id.to_i()
    @@list.each do |word|
      if word.id == word_id
        return word
      end
    end
  end

  def save()
    if @@list.all? do |word|
      self.vocab != ""
      end
      @@list.push(self)
    end
  end

  def add_definition(definition)
    @definitions.push(definition)
  end

  def self.list
   @definitions
  end

  def self.delete(id)
    word_id = id.to_i()
    @@list.map do |word_del|
      if word_del.id == word_id
        word_del.vocab = ""
      end
    end
  end

  def self.sort()
    @@list.sort_by! {|x| x.vocab}
  end

end
