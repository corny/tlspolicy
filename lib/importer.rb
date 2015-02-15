require 'zgrab'

module Importer

  def self.import(json)
    result = Zgrab::Result.new(json)
    if result.certificates
      certs       = result.certificates.map{ |cert| RawCertificate.find_or_create cert, seen_at: result.time }
      certificate = certs.first
    else
      certificate = nil
    end

    MxHost.where(hostname: result.domain, address: result.host).update_all \
      starttls:         result.starttls?,
      tls_cipher_suite: result.tls_cipher_suite,
      tls_version:      result.tls_version,
      cert_valid:       result.certificate_valid?,
      certificate_id:   certificate.try(:id)

    result
  end

end