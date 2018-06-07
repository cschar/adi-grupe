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

# <%= m_react_component('ReactButtonClass', 
#                       { button_prop_name: 'click me '})
# <%= m_render_component(Form, {}) %>


end
