GovukPublishingComponents::Engine.routes.draw do
  root to: 'component_guide#index', as: :component_guide
  get 'preview-all' => 'component_guide#preview_all',  as: :component_all
  get ':component/preview' => 'component_guide#preview', as: :component_preview_all
  get ':component/:example/preview' => 'component_guide#preview', as: :component_preview
  get ':component' => 'component_guide#show', as: :component_doc
  get ':component/:example' => 'component_guide#example', as: :component_example

end
