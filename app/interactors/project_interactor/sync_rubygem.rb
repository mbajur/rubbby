module ProjectInteractor
  class SyncRubygem
    include Interactor

    def call
      if context.project.rubygem_name.present?
        Rubygems::ProjectGemService.new(context.project).sync
      end
    end
  end
end