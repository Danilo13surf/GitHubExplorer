//
//  GHEConstants.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import Foundation

// MARK: - GHEConstants
// swiftlint:disable convenience_type
enum GHEConstants {
    // MARK: - PathApi
    class GHEPathApi {
        let users = "users"
        let repos = "users/%@/repos"
        let user = "users/%@"
    }
    class Constants {
        static let imageViewSize: CGFloat = 70
        static let avatarViewBoderWidth: CGFloat = 2
        static let primaryButtonText: String = "Tentar novamente"
        static let alertMessage: String = "Error"
        static let alertDescription: String = "Erro ao buscar os dados!"
        static let welcomeText: String = "Bem vindo a busca de usuarios do github, toque na tela para continuar"
        static let userTitle: String = "Lista de repositorios de "
        static let listTitle: String = "Lista de Usuarios"
        static let backButtonIcon: String = "icon_arrow_chevron_left"
        static let logoGithub: String = "logo_github"
        static let loadingText: String = "Espere só mais um pouco"
        static let searchTitle: String = "Pesquisar por login"
        static let moreInfoText = "Mais informações"
        static let textDownloadError = "Erro ao fazer o download da imagem:"
        static let textNotFoundData = "Dados da imagem não encontrados."
        static let showRepositories = "Mostrar Repositorios"
        static let goRepositories = "Toque em um Repositorio abrir no site"
        static let texImageCorrupted = "Não foi possível criar a imagem a partir dos dados recebidos."
    }
}
// swiftlint:enable convenience_type
