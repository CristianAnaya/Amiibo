//
//  ReleaseMapper.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation
import Domain
import CoreData

struct ReleaseMapper {
    
    static func fromDtoToDomain(releaseDto: ReleaseDto) -> Release {
        let release = Release(
            au: releaseDto.au,
            eu: releaseDto.eu,
            jp: releaseDto.jp,
            na: releaseDto.na
        )
        
        return release
    }
    
    static func fromEntityToDomain(releaseEntity: ReleaseEntity) -> Release {
        let release = Release(
            au: releaseEntity.au,
            eu: releaseEntity.eu,
            jp: releaseEntity.jp,
            na: releaseEntity.na
        )
        
        return release
    }
    
    static func fromDomainToEntity(release: Release, context: NSManagedObjectContext) -> ReleaseEntity {
        let releaseEntity = ReleaseEntity(context: context)
        releaseEntity.au = release.au
        releaseEntity.eu = release.eu
        releaseEntity.jp = release.jp
        releaseEntity.na = release.na
        
        return releaseEntity
    }
    
}
