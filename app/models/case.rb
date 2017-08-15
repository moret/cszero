class Case
  include Mongoid::Document

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

  validates :type, inclusion: TYPES.keys.map {|key| key.to_s }
  validates :uf, inclusion: BRAZIL_UFS.keys.map {|key| key.to_s }
  validates :reason, inclusion: REASONS.keys.map {|key| key.to_s }
end
