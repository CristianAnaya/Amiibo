//
//  AmiiboMapper.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation
import Domain
import CoreData

struct AmiiboMapper {
    
    static func fromDtoToDomain(amiiboDto: AmiiboDto) throws -> Amiibo {
        let amiibo = try Amiibo(
            head: amiiboDto.head,
            tail: amiiboDto.tail,
            name: amiiboDto.name,
            amiiboSeries: amiiboDto.amiiboSeries,
            type: amiiboDto.type,
            image: amiiboDto.image,
            character: amiiboDto.character,
            release: ReleaseMapper.fromDtoToDomain(releaseDto: amiiboDto.release)
        )
        
        return amiibo
    }
    
    static func fromEntityToDomain(amiiboEntity: AmiiboEntity) throws -> Amiibo {
        let amiibo = try Amiibo(
            head: amiiboEntity.head,
            tail: amiiboEntity.tail,
            name: amiiboEntity.name,
            amiiboSeries: amiiboEntity.amiiboSeries,
            type: amiiboEntity.type,
            image: amiiboEntity.image,
            character: amiiboEntity.character,
            release: ReleaseMapper.fromEntityToDomain(releaseEntity: amiiboEntity.amiiboRelease)
        )
        
        return amiibo
    }
    
    static func fromDomainToEntity(amiibo: Amiibo, context: NSManagedObjectContext) -> AmiiboEntity {
        let amiiboEntity = AmiiboEntity(context: context)
        amiiboEntity.head = amiibo.head
        amiiboEntity.tail = amiibo.tail
        amiiboEntity.name = amiibo.name
        amiiboEntity.amiiboSeries = amiibo.amiiboSeries
        amiiboEntity.type = amiibo.type
        amiiboEntity.image = amiibo.image
        amiiboEntity.character = amiibo.character
        amiiboEntity.amiiboRelease = ReleaseMapper.fromDomainToEntity(release: amiibo.release, context: context)
        
        return amiiboEntity
    }
    
}
