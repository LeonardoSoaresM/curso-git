while true do
  print("What email?")
  local input = io.read()
  local email = string.gsub(input, "%s+", ""):lower()

  local atIndex = email.find(email, "@")

  if atIndex ~= nil then
    local user = string.sub(email, 1, atIndex - 1)
    local domain = string.sub(email, atIndex + 1, #email)

    print("Valid email!" .. "\nUser: " .. user, "\nDomain: " .. domain)
    print(email)

    break
  end

  print("Try again, invalid email: missing '@'")
end
