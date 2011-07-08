module BranchesHelper
  def jitTreeChart 
    strata_children = []
    cities = City.find_all_by_jb_present('Y',:order=>'name desc')
    cities.each do |city|
      city_children = []  
      branches = Branch.find_all_by_city_id_and_category(city.id, ['P','W'], :order=>'branch_name')
      branches.each do |branch|
        branch_children =[]
        sats = Branch.find_all_by_parent_id_and_category(branch.id, 'S')
        #sats << branch
        sats.each do |sat|
          branch_child ={"id" => sat.id, "name"=>sat.branch_name, "data"=>{"band"=>branch.branch_name, "relation"=>"satellite", "subdomain"=>branch.subdomain,"brn_id"=>sat.id}, "children"=>[]}
          branch_children << branch_child 
        end
        city_child = {"id"=>"fran_"+branch.id.to_s, "name"=>branch.branch_name, "data"=>{"band"=>city.name, "relation"=>"branch", "subdomain"=>branch.subdomain,"brn_id"=>branch.id}, "children"=>branch_children}
        city_children << city_child
      end
      strata_child = {"id"=>"801_"+city.id.to_s, "name"=>city.name, "data"=>{"band"=>"JustbooksClc", "relation"=>"city","subdomain"=>"city"},"children"=>city_children}
      strata_children << strata_child
    end
    #strata_child = {"id"=>"801", "name"=>"Strata Staff", "data"=>{"band"=>"JustbooksClc", "relation"=>"city","subdomain"=>"strata"},"children"=>[]}
    #strata_children << strata_child
    json = {
      "id"=> "801_jb",
      "name" => "JustbooksClc",
      "children"=>strata_children,
      "data"=>{ "subdomain"=>"city"}
    }
  end
end
