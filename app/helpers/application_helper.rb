module ApplicationHelper
  def sort_level(switches)

    tree_switches = []

    tree = {}
    parents = []
    items = []

    switches.each do |s|
      parent = s.destination.to_s.blank? ? 'core' : s.destination
      tree[parent] ||= []
      tree[parent] << s
      parents << parent
      items << s.source
    end

    unique_items = items.uniq
    unique_parents = parents.uniq

    unique_parents.each do |item|
      if item == 'core'
        next
      end

      if tree["core"][0].group_id == 3
      end
      if !unique_items.include?(item)
        desc = Switch.where(source: item).first
        tree["core"] << Switch.new(fake: true, destination: 'core', source: item, description: desc.description, id: 999999)
      end
    end

    if tree["core"]
      tree["core"].each do |s1|
        s1.level = 1
        tree_switches << s1
        if tree[s1.source]
          tree[s1.source].each do |s2|
            s2.level = 2
            tree_switches << s2
            if tree[s2.source]
              tree[s2.source].each do |s3|
                s3.level = 3
                tree_switches << s3
                if tree[s3.source]
                  tree[s3.source].each do |s4|
                    s4.level = 4
                    tree_switches << s4
                  end
                end
              end
            end
          end
        end
      end
    end

    tree_switches
  end


  def switches_options(chosen)
    options_for_select(@switches.map{ |c| [c.source, c.source] }, chosen)
  end

end
