class Case
  include Mongoid::Document

  def self.report
    Case.collection.aggregate([
      {
        '$sort': { date: -1 }
      },
      {
        '$project': {
          day: {
            '$dateToString': { format: '%Y-%m-%d', date: '$date' }
          },
          type: 1,
          uf: 1,
          reason: 1,
          notes: 1,
          date: 1,
          email: 1
        }
      },
      {
        '$group': {
          _id: { day: '$day', uf: '$uf' },
          cases: { '$push': '$$ROOT' }
        }
      },
      {
        '$sort': { '_id.day': -1, '_id.uf': 1 }
      }
    ]).map do |day_uf|
      RecursiveOpenStruct.new day_uf, recurse_over_arrays: true
    end
  end

  TYPES = {
    phone: 'Telefone',
    chat: 'Chat',
    email: 'Email',
  }

  BRAZIL_UFS = {
    AC: 'Acre',
    AL: 'Alagoas',
    AM: 'Amazonas',
    AP: 'Amapá',
    BA: 'Bahia',
    CE: 'Ceará',
    DF: 'Distrito Federal',
    ES: 'Espírito Santo',
    GO: 'Goiás',
    MA: 'Maranhão',
    MG: 'Minas Gerais',
    MS: 'Mato Grosso do Sul',
    MT: 'Mato Grosso',
    PA: 'Pará',
    PB: 'Paraíba',
    PE: 'Pernambuco',
    PI: 'Piauí',
    PR: 'Paraná',
    RJ: 'Rio de Janeiro',
    RN: 'Rio Grande do Norte',
    RO: 'Rondônia',
    RR: 'Roraima',
    RS: 'Rio Grande do Sul',
    SC: 'Santa Catarina',
    SE: 'Sergipe',
    SP: 'São Paulo',
    TO: 'Tocantins',    
  }

  REASONS = {
    question: 'Dúvida',
    compliment: 'Elogio',
    suggestion: 'Sugestão',
  }

  field :type
  field :uf
  field :reason
  field :notes
  field :date, type: DateTime
  field :email

  before_create :save_date

  validates :type, presence: true, inclusion: TYPES.keys.map {|key| key.to_s}
  validates :uf, presence: true, inclusion: BRAZIL_UFS.keys.map {|key| key.to_s}
  validates :reason, presence: true, inclusion: REASONS.keys.map {|key| key.to_s}
  validates :notes, presence: true
  validates :email, presence: true

protected

  def save_date
    self.date ||= DateTime.now
  end
end
