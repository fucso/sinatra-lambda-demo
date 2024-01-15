module UseCase
  module Plan
    class Index
      def execute
        {
          plans: [
            {
              id: 1,
              name: 'Plan 1',
            },
            {
              id: 2,
              name: 'Plan 2',
            },
          ]
        }
      end
    end
  end
end