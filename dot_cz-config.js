module.exports = {
  types: [
    {
      value: ":sparkles: feat",
      name: "✨ feat:\t新機能追加",
    },
    {
      value: ":bug: fix",
      name: "🐛 fix:\tバグ修正",
    },
    {
      value: ":wrench: settings",
      name: "🔧 settings:\tconfigファイルの追加/更新",
    },
    {
      value: ":memo: docs",
      name: "📚 docs:\tドキュメントの変更",
    },
    {
      value: ":lipstick: style",
      name: "💄 style:\tスタイルの追加・更新",
    },
    {
      value: ":shirt: lint",
      name: "👕 lint:\tLintエラーの修正やコードスタイルの修正",
    },
    {
      value: ":recycle: refactor",
      name: "♻️ refactor:\tリファクタリングのための変更\n\t\t（機能追加やバグ修正を含まない変更）",
    },
    {
      value: ":zap: perf",
      name: "⚡️ perf:\tパフォーマンス改善のための変更",
    },
    {
      value: ":white_check_mark: test",
      name: "✅  test:\tテストやCIの修正・改善",
    },
    {
      value: ":truck: chore",
      name: "🚚 chore:\tその他の変更\n\t\t（補助ツール、ドキュメント生成などのソースやテストの変更を含まない変更）",
    },
    {
      value: ":rewind: revert",
      name: "⏪️ revert:\tRevertコミット",
    },
    {
      value: ":construction: wip",
      name: "🚧 wip:\t作業中",
    },
    {
      value: ":fire: delete",
      name: "🔥 delete:\t不要な機能・使われなくなった機能の削除",
    },
    {
      value: ":green_heart: ci",
      name: "💚 ci:\tCIの修正・改善",
    },
  ],
  scopes: ["components", "pages", "database", "api", "other"],
  messages: {
    type: "コミットする変更タイプを選択:\n",
    scope: "変更内容のスコープ(例:コンポーネントやファイル名)(optional):\n",
    customScope:
      "変更内容のスコープ(例:コンポーネントやファイル名)(optional):\n",
    subject: "変更内容を要約した本質的説明:\n",
    body: '変更内容の詳細（"|"で改行）(optional):\n',
    breaking: "破壊的変更についての記述(optional):\n",
    footer: '関連issueを追記 (例:"fix #123", "re #123")(optional):\n',
    confirmCommit: "このコミット内容でよろしいですか?",
  },
};
