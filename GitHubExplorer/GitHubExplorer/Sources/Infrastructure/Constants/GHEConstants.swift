//
//  GHEConstants.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import Foundation

// MARK: - GHEConstants
enum GHEConstants {
    // MARK: - PathApi
    class GHEPathApi {
        let users = "users"
        let repos = "users/%@/repos"
    }
    
    class Constants {
        static let primaryButtonText: String = "Tentar novamente"
        static let alertMessage: String = "Error"
        static let alertDescription: String = "Erro ao buscar os dados!"
        static let welcomeText: String = "Bem vindo a busca de usuarios do github, toque na tela para continuar"
        static let userTitle: String = "Usuario:"
        static let listTitle: String = "Lista de Usuarios"
        static let backButtonIcon: String = "icon_arrow_chevron_left"
        static let loadingText: String = "Espere só mais um pouco"
    }
}
