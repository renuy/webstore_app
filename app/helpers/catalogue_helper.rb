module CatalogueHelper

  def get_collection(collection_name_id)
    collection = CollectionName.find(collection_name_id)
    titles = []
    titles = collection.collection.collect {|x| x.title.id}
    return titles
  end
  
  def get_random_page(collection)
    no_of_page = (collection.total_entries.to_i/9).to_i < collection.total_entries.to_f/9 ? (collection.total_entries.to_i/9).to_i + 1 : (collection.total_entries.to_i/9).to_i
    no_of_page == 0 ? 1 : rand(no_of_page) + 1
  end
  
end
