'use strict';
module.exports = {
  types: [
    {
      name: 'feat',
      code: 'feat: :+1:',
      emoji: '👍',
      description: '新機能'
    },
    {
      name: 'fix',
      code: 'fix: :bug:',
      emoji: '🐛',
      description: 'バグ修正'
    },
    {
      name: 'wip',
      code: 'wip: :construction:',
      emoji: '🚧',
      description: '作業中'
    },
    {
      name: 'chore',
      code: 'chore: :paperclip:',
      emoji: '📎',
      description: 'その他の変更\n           （補助ツール、ドキュメント生成などのソースやテストの変更を含まない変更）'
    },
    {
      name: 'style',
      code: 'style: :sparkles:',
      emoji: '✨',
      description: 'フォーマットの変更\n          （コードの動作に影響しないスペース、フォーマット、セミコロンなどの変更)'
    },
    {
      name: 'docs',
      code: 'docs: :books:',
      emoji: '\uD83D\uDCDA ',
      description: 'ドキュメントのみの変更'
    },
    {
      name: 'perf',
      code: 'perf: :zap:',
      emoji: '⚡',
      description: 'パフォーマンスの改善のための変更'
    },
    {
      name: 'refactor',
      code: 'refactor: :recycle:',
      emoji: '♻️',
      description: 'リファクタリングのための変更\n            （機能追加やバグ修正を含まない変更）'
    },
    {
      name: 'test',
      code: 'test: :green_heart:',
      emoji: '\uD83D\uDC9A',
      description: 'テストやCIの修正・改善'
    },
    {
      name: 'release',
      code: 'release :tada:',
      emoji: '🎉',
      description: '公開'
    }
  ],
  messages: {
    type: 'コミットする変更タイプを選択:\n',
    scope: '変更内容のスコープ(例:コンポーネントやファイル名)(optional):\n',
    // used if allowCustomScopes is true
    customScope: '変更内容のスコープ(例:コンポーネントやファイル名)(optional):\n',
    subject: '変更内容を要約した本質的説明:\n',
    body: '変更内容の詳細（"|"で改行）(optional):\n',
    breaking: '破壊的変更についての記述(optional):\n',
    footer: '関連issueを追記 (例:"fix #123", "re #123")(optional):\n',
    confirmCommit: 'このコミット内容でよろしいですか?'
  },
  allowCustomScopes: true,
  allowBreakingChanges: ['feat', 'fix']
};