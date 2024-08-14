class NotaFiscal < ApplicationRecord
  self.table_name = 'notas_fiscais'

  has_one_attached :xml

  belongs_to :emitente
  belongs_to :destinatario

  has_many :produtos
end
