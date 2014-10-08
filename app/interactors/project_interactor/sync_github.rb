module ProjectInteractor
  class SyncGithub
    include Interactor

    def call
      Github::ProjectRepoService.new(context.project).sync
    end
  end
end
