module Stats

  extend self

  def tls_versions
    MxHost.where("tls_version IS NOT NULL").select("tls_version, COUNT(*) AS count").group(:tls_version).order(:tls_version)
  end

  def hostnames_per_address(limit=50)
    MxHost.select("address, COUNT(*) AS count").group(:address).order("count DESC").limit(limit)
  end

  def issuers(limit=50)
    Certificate.select("min(id) AS id, issuer_id, count(*) AS count").group(:issuer_id).order("count DESC").limit(limit)
  end

end