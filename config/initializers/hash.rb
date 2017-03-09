class Hash
  def sample(n)
    if n == 1
    	Hash[to_a.sample(n)].keys[0]
    else
    	#Hash[to_a.sample(n)]
    end
  end
end