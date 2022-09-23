//
//  LocalDataSource.swift
//  NewsApp
//
//  Created by Menna on 21/09/2022.
//

import Foundation
import CoreData
protocol LocalDataSourcable{
    func removeArticleFromCoreData(articleTitle: String) throws
    func getArticleFromCoreData() throws -> [Articles]
    func isFavouriteArticle(data: String,auther:String) throws -> Bool
    func saveoCoreData(title: String,img:String,desc:String,source:String, data: String,auther:String )throws
}
class LocalDataSource:LocalDataSourcable{
    private var context: NSManagedObjectContext!
    private var entity: NSEntityDescription!
    init(appDelegate: AppDelegate){
        context = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Articles", in: context)
      
    }
    func saveoCoreData(title: String,img:String,desc:String,source:String, data: String, auther:String )throws{
        let news = Articles(entity: entity, insertInto: context)
        news.articleTitle=title
        news.articleImg=img
        news.articleDesc=desc
        news.articleSource=source
        news.articleData=data
        news.auther=auther
        do{
            try context.save()

        }catch let error as NSError{
            throw error
        }

    }
    func removeArticleFromCoreData(articleTitle: String) throws{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Articles")
        let myPredicate = NSPredicate(format: "articleTitle == %@", articleTitle)
               fetchRequest.predicate = myPredicate
               do{
                   let productList = try context.fetch(fetchRequest)
                   for product in productList{
                       context.delete(product)
                   }
                   try self.context.save()
               }catch let error as NSError{
                   throw error
               }
    }
    
    func getArticleFromCoreData()throws -> [Articles] {
        var articlesSelect : [Articles] = []
        let fetchRequest = Articles.fetchRequest()
        do{
          let articlesList = try context.fetch(fetchRequest)
            for item in articlesList {
                articlesSelect.append(item)
            }
            return articlesSelect
        }
        catch let error as NSError{
            throw error
            
        }
    }
    
    func isFavouriteArticle(data: String,auther:String) throws -> Bool {
        do{
            let news = try self.getArticleFromCoreData()
        for item in news{
            if item.articleData == data && item.auther == auther {
            return true
            }
        }
        }catch let error{
            throw error
        }
     return false
    }
    
    

}
