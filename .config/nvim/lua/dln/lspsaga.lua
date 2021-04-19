require("lspsaga").init_lsp_saga {
  use_saga_diagnostic_sign = true,
  -- error_sign = "",
  -- warn_sign = "",
  -- infor_sign = "",
  -- hint_sign = "➤",
  code_action_prompt = {enable = false},
  border_style = "round",
  max_preview_lines = 20,
}
