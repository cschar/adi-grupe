module ApplicationHelper


  def m_render_component(component, props)
    component
       .new({context: self}.merge(props))
       .render()
  end

  def m_react_component(component_name, props)
    tag.div data: { component_name: component_name,
                    react_props: props.to_json }

  end

  def name_gen
    name = FFaker::Color.name  + FFaker::CheesyLingo.sentence.split(" ").sample

    tag.div tag.p(name), id: "tag"
  end


end
