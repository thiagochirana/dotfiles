require 'io/console'
require 'dotenv'

Dotenv.load

def list_files(directory)
  Dir.entries(directory) - ['.', '..']
end

def send_file(file, destination)
  server_user = ENV['SERVER_HOME_UBUNTU_USER']
  server_ip = ENV['SERVER_HOME_UBUNTU_IP']
  ssh_key = ENV['SERVER_HOME_UBUNTU_SSH_KEY_PATH']

  if server_ip.nil?
    puts 'Erro: Variável de ambiente SERVER_HOME_UBUNTU_IP não definida.'
    exit 1
  end

  if server_user.nil?
    puts 'Erro: Variável de ambiente SERVER_HOME_UBUNTU_USER não definida.'
    exit 1
  end

  if ssh_key.nil?
    puts 'Erro: Variável de ambiente SERVER_HOME_UBUNTU_SSH_KEY_PATH não definida.'
    exit 1
  end

  command = "scp -i #{ssh_key} #{file} #{server_user}@#{server_ip}:#{destination}"
  puts "Enviando #{file} para #{destination}..."
  system(command)
  puts 'Arquivo enviado!'
end

puts 'Você gostaria de:'
puts '1 - Especificar o caminho completo'
puts '2 - Escolher a partir do diretório atual'
print '? '
menu_choice = gets.chomp.to_i

if menu_choice == 1
  print 'Digite o caminho completo do arquivo: '
  file_path = gets.chomp
  if File.exist?(file_path)
    print 'Digite o caminho de destino no servidor (~ por padrão): '
    destination = gets.chomp
    destination = '~' if destination.empty?
    send_file(file_path, destination)
  else
    puts 'Arquivo não encontrado.'
  end
elsif menu_choice == 2
  puts 'Selecione um arquivo para enviar ao servidor:'
  files = list_files('.')
  files.each_with_index { |file, index| puts "#{index + 1}. #{file}" }

  print 'Digite o número do arquivo: '
  choice = gets.chomp.to_i

  if choice.between?(1, files.length)
    selected_file = files[choice - 1]
    print 'Digite o caminho de destino no servidor (~ por padrão): '
    destination = gets.chomp
    destination = '~' if destination.empty?
    send_file(selected_file, destination)
  else
    puts 'Escolha inválida.'
  end
else
  puts 'Opção inválida.'
end